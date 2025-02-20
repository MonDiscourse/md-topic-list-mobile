import { and } from "truth-helpers";
import TopicPostBadges from "discourse/components/topic-post-badges";
import avatar from "discourse/helpers/avatar";
import icon from "discourse/helpers/d-icon";
import formatDate from "discourse/helpers/format-date";
import { number } from "discourse/lib/formatter";
import { withPluginApi } from "discourse/lib/plugin-api";

const EmptyContent = <template>{{~! no whitespace ~}}</template>;

const CommentContent = <template>
  <span class="comments">
    {{icon "far-comment"}}
    <a href="{{@outletArgs.topic.firstPostUrl}}">{{number
        @outletArgs.topic.replyCount
        noTitle="true"
      }}
    </a>
  </span>
</template>;

const LastPostContent = <template>
  <td class="last-post">
    <div class="poster-avatar">
      {{#if
        (and @outletArgs.showTopicPostBadges @outletArgs.topic.unread_posts)
      }}
        <TopicPostBadges
          @unreadPosts={{@outletArgs.topic.unread_posts}}
          @unseen={{@outletArgs.topic.unseen}}
          @url={{@outletArgs.topic.lastUnreadUrl}}
        />
      {{else}}
        <a
          href={{@outletArgs.topic.lastPostUrl}}
          data-user-card={{@outletArgs.topic.last_poster_username}}
        >{{avatar @outletArgs.topic.lastPosterUser imageSize="small"}}
        </a>
      {{/if}}
    </div>
    <div class="num activity last poster-info">
      <span title={{@outletArgs.topic.bumpedAtTitle}} class="age activity">
        <a href={{@outletArgs.topic.lastPostUrl}}>{{formatDate
            @outletArgs.topic.bumpedAt
            format="tiny"
            noTitle="true"
          }}
        </a>
      </span>

    </div>
  </td>
</template>;

function initialize(api) {
  const site = api.container.lookup("service:site");

  if (!site.mobileView) {
    return;
  }

  api.renderInOutlet("topic-list-item-mobile-avatar", EmptyContent);
  api.renderInOutlet("topic-list-after-category", CommentContent);
  api.renderAfterWrapperOutlet("topic-list-item", LastPostContent);
}

export default {
  name: "md-topic-list-mobile",

  initialize() {
    withPluginApi("1.28.0", (api) => initialize(api));
  },
};

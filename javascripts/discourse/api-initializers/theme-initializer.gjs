import Component from "@glimmer/component";
import { apiInitializer } from "discourse/lib/api";
import DUserLink from "discourse/ui-kit/d-user-link";
import dAvatar from "discourse/ui-kit/helpers/d-avatar";
import dFormatDate from "discourse/ui-kit/helpers/d-format-date";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import TopicPostBadges from "discourse/components/topic-post-badges";
import { number } from "discourse/lib/formatter";
import { service } from "@ember/service";
import { i18n } from "discourse-i18n";


export default apiInitializer((api) => {
  api.renderInOutlet(
    "topic-list-item-mobile-avatar",
    <template>
		{{~! no whitespace ~}}
    </template>
  );

  api.renderInOutlet(
    "topic-list-after-title",
    <template>
      <span class="mdtlm">
        <TopicPostBadges
          @unreadPosts={{@outletArgs.topic.unread_posts}}
          @url={{@outletArgs.topic.lastUnreadUrl}}
        />
      </span>
    </template>
  );
  
  api.renderInOutlet(
    "topic-list-after-category",
    <template>
      <span class="mdtlm comments">
		{{dIcon "far-comment"}}
		<a href="{{@outletArgs.topic.firstPostUrl}}">{{number
			@outletArgs.topic.replyCount
			noTitle="true"
		}}
		</a>
		</span>
    </template>
  );
  
  api.renderInOutlet(
    "topic-list-main-link-bottom",
    <template>
      <div class="mdtlm category-author-comments">
		<span class="topic-creator">
			{{dIcon "user"}} <a href="/users/{{@topic.creator.username}}" data-auto-route="true" data-user-card="{{@topic.creator.username}}">{{@topic.creator.username}}</a>
		</span>
		<span class="comments-cat">
			{{dIcon "far-comment"}} <a href="{{@topic.firstPostUrl}}">{{number @topic.posts_count}}</a>
		</span>
	</div>
    </template>
  );
  
  api.renderAfterWrapperOutlet(
    "topic-list-item",
    <template>
	<td class="mdtlm last-post">
	  <div class="poster-avatar">
        <a
          href={{@outletArgs.topic.lastPostUrl}}
          data-user-card={{@outletArgs.topic.last_poster_username}}
        >{{dAvatar @outletArgs.topic.lastPosterUser imageSize="small"}}
        </a>
	  </div>
	  <div class="num activity last poster-info">
		<span title={{@outletArgs.topic.bumpedAtTitle}} class="age activity">
			<a href={{@outletArgs.topic.lastPostUrl}}>{{dFormatDate
				@outletArgs.topic.bumpedAt
				format="tiny"
				noTitle="true"
			}}
			</a>
		</span>
	  </div>
	</td>
    </template>
  );
});

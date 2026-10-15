-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: idxwp_posts_post_parent
-- Type: INDEX

-- Name: idxwp_posts_post_parent; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX idxwp_posts_post_parent ON khi.wp_posts USING btree (post_parent);


--

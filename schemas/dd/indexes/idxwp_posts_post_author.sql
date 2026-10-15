-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_posts_post_author
-- Type: INDEX

-- Name: idxwp_posts_post_author; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_posts_post_author ON dd.wp_posts USING btree (post_author);


--

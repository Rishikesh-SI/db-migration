-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_posts_post_name
-- Type: INDEX

-- Name: idxwp_posts_post_name; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_posts_post_name ON dd.wp_posts USING btree (post_name);


--

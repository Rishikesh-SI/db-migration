-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_posts_post_name
-- Type: INDEX

-- Name: idxwp_posts_post_name; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_posts_post_name ON swa.wp_posts USING btree (post_name);


--

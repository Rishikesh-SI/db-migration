-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_posts_post_name
-- Type: INDEX

-- Name: idxwp_posts_post_name; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_posts_post_name ON tfa.wp_posts USING btree (post_name);


--

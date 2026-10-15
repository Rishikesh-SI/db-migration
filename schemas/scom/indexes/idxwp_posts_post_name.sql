-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: idxwp_posts_post_name
-- Type: INDEX

-- Name: idxwp_posts_post_name; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX idxwp_posts_post_name ON scom.wp_posts USING btree (post_name);


--

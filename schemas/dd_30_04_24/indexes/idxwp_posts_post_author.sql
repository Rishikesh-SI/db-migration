-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_posts_post_author
-- Type: INDEX

-- Name: idxwp_posts_post_author; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_posts_post_author ON dd_30_04_24.wp_posts USING btree (post_author);


--

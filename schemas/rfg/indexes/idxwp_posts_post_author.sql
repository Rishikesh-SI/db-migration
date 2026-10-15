-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_posts_post_author
-- Type: INDEX

-- Name: idxwp_posts_post_author; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX idxwp_posts_post_author ON rfg.wp_posts USING btree (post_author);


--

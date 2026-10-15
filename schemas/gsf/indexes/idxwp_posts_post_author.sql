-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_posts_post_author
-- Type: INDEX

-- Name: idxwp_posts_post_author; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_posts_post_author ON gsf.wp_posts USING btree (post_author);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_posts_post_type_post_status_post_date_ID
-- Type: INDEX

-- Name: idxwp_posts_post_type_post_status_post_date_ID; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX "idxwp_posts_post_type_post_status_post_date_ID" ON swa.wp_posts USING btree (post_type, post_status, post_date, post_id);


--

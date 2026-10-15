-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_posts_post_type_post_status_post_date_ID
-- Type: INDEX

-- Name: idxwp_posts_post_type_post_status_post_date_ID; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX "idxwp_posts_post_type_post_status_post_date_ID" ON rfg.wp_posts USING btree (post_type, post_status, post_date, post_id);


--

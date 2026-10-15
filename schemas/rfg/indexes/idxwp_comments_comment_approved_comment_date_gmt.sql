-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_comments_comment_approved_comment_date_gmt
-- Type: INDEX

-- Name: idxwp_comments_comment_approved_comment_date_gmt; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX idxwp_comments_comment_approved_comment_date_gmt ON rfg.wp_comments USING btree (comment_approved, comment_date_gmt);


--

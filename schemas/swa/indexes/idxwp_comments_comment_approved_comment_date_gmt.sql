-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_comments_comment_approved_comment_date_gmt
-- Type: INDEX

-- Name: idxwp_comments_comment_approved_comment_date_gmt; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_comments_comment_approved_comment_date_gmt ON swa.wp_comments USING btree (comment_approved, comment_date_gmt);


--

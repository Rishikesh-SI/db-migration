-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_comments_comment_approved_comment_date_gmt
-- Type: INDEX

-- Name: idxwp_comments_comment_approved_comment_date_gmt; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_comments_comment_approved_comment_date_gmt ON tfa.wp_comments USING btree (comment_approved, comment_date_gmt);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_comments_comment_approved_comment_date_gmt
-- Type: INDEX

-- Name: idxwp_comments_comment_approved_comment_date_gmt; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_comments_comment_approved_comment_date_gmt ON gsf.wp_comments USING btree (comment_approved, comment_date_gmt);


--

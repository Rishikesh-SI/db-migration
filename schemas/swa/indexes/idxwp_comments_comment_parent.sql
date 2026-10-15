-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON swa.wp_comments USING btree (comment_parent);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON khi.wp_comments USING btree (comment_parent);


--

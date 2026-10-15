-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON dd.wp_comments USING btree (comment_parent);


--

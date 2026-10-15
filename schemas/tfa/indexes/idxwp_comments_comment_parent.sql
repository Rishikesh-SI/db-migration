-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON tfa.wp_comments USING btree (comment_parent);


--

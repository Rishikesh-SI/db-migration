-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON scom.wp_comments USING btree (comment_parent);


--

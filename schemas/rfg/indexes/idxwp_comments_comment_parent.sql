-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON rfg.wp_comments USING btree (comment_parent);


--

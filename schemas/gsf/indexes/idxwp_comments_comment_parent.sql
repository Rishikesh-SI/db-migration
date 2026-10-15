-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON gsf.wp_comments USING btree (comment_parent);


--

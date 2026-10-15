-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_comments_comment_author_email
-- Type: INDEX

-- Name: idxwp_comments_comment_author_email; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_comments_comment_author_email ON tfa.wp_comments USING btree (comment_author_email);


--

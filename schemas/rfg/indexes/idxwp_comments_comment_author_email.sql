-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_comments_comment_author_email
-- Type: INDEX

-- Name: idxwp_comments_comment_author_email; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX idxwp_comments_comment_author_email ON rfg.wp_comments USING btree (comment_author_email);


--

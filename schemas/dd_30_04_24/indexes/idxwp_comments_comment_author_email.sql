-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_comments_comment_author_email
-- Type: INDEX

-- Name: idxwp_comments_comment_author_email; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_comments_comment_author_email ON dd_30_04_24.wp_comments USING btree (comment_author_email);


--

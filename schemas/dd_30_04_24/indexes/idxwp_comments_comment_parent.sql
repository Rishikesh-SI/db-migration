-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_comments_comment_parent
-- Type: INDEX

-- Name: idxwp_comments_comment_parent; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_comments_comment_parent ON dd_30_04_24.wp_comments USING btree (comment_parent);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: idxwp_postmeta_post_id
-- Type: INDEX

-- Name: idxwp_postmeta_post_id; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX idxwp_postmeta_post_id ON khi.wp_postmeta USING btree (post_id);


--

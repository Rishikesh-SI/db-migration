-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_postmeta_post_id
-- Type: INDEX

-- Name: idxwp_postmeta_post_id; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_postmeta_post_id ON dd.wp_postmeta USING btree (post_id);


--

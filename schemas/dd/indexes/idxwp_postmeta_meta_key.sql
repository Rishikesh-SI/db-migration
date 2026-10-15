-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON dd.wp_postmeta USING btree (meta_key);


--

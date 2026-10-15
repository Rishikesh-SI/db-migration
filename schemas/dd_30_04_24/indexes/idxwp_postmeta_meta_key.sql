-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON dd_30_04_24.wp_postmeta USING btree (meta_key);


--

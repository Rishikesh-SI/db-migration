-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON scom.wp_postmeta USING btree (meta_key);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON swa.wp_postmeta USING btree (meta_key);


--

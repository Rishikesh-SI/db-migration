-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON tfa.wp_postmeta USING btree (meta_key);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON rfg.wp_postmeta USING btree (meta_key);


--

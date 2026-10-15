-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON gsf.wp_postmeta USING btree (meta_key);


--

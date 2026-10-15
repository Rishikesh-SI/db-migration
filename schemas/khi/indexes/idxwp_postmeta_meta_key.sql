-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: idxwp_postmeta_meta_key
-- Type: INDEX

-- Name: idxwp_postmeta_meta_key; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX idxwp_postmeta_meta_key ON khi.wp_postmeta USING btree (meta_key);


--

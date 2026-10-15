-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_terms_name
-- Type: INDEX

-- Name: idxwp_terms_name; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_terms_name ON dd_30_04_24.wp_terms USING btree (name);


--

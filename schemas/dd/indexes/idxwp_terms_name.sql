-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_terms_name
-- Type: INDEX

-- Name: idxwp_terms_name; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_terms_name ON dd.wp_terms USING btree (name);


--

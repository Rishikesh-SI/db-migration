-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: idxwp_terms_name
-- Type: INDEX

-- Name: idxwp_terms_name; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX idxwp_terms_name ON scom.wp_terms USING btree (name);


--

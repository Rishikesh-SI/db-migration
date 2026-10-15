-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_terms_name
-- Type: INDEX

-- Name: idxwp_terms_name; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_terms_name ON swa.wp_terms USING btree (name);


--

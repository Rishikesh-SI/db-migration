-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_terms_name
-- Type: INDEX

-- Name: idxwp_terms_name; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_terms_name ON tfa.wp_terms USING btree (name);


--

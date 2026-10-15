-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_terms_slug
-- Type: INDEX

-- Name: idxwp_terms_slug; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_terms_slug ON swa.wp_terms USING btree (slug);


--

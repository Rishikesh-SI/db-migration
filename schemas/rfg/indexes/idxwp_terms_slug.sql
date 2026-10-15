-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: idxwp_terms_slug
-- Type: INDEX

-- Name: idxwp_terms_slug; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX idxwp_terms_slug ON rfg.wp_terms USING btree (slug);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: idxwp_terms_slug
-- Type: INDEX

-- Name: idxwp_terms_slug; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX idxwp_terms_slug ON scom.wp_terms USING btree (slug);


--

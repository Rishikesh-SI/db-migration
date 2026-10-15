-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_entity_partner_lmid
-- Type: INDEX

-- Name: ix_pkl_entity_partner_lmid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_entity_partner_lmid ON labpkl.labpkl_entity_language_map USING btree (language_master_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_entity_partner_lmid
-- Type: INDEX

-- Name: ix_pkl_entity_partner_lmid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_entity_partner_lmid ON pkl.pkl_entity_language_map USING btree (language_master_id);


--

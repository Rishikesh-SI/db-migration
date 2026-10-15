-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_entity_role_etid
-- Type: INDEX

-- Name: ix_gsf_entity_role_etid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_entity_role_etid ON gsf.gsf_entity_role USING btree (entity_type_id);


--

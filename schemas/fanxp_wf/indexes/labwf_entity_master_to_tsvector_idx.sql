-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_entity_master_to_tsvector_idx
-- Type: INDEX

-- Name: labwf_entity_master_to_tsvector_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_entity_master_to_tsvector_idx ON fanxp_wf.labwf_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

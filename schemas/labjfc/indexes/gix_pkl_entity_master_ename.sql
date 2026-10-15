-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: gix_pkl_entity_master_ename
-- Type: INDEX

-- Name: gix_pkl_entity_master_ename; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX gix_pkl_entity_master_ename ON labjfc.labjfc_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

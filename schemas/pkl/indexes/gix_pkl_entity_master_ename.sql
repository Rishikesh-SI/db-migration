-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: gix_pkl_entity_master_ename
-- Type: INDEX

-- Name: gix_pkl_entity_master_ename; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX gix_pkl_entity_master_ename ON pkl.pkl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

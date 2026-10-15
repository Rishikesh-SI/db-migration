-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_entity_master_to_tsvector_idx
-- Type: INDEX

-- Name: upstox_entity_master_to_tsvector_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_entity_master_to_tsvector_idx ON upstox.upstox_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--

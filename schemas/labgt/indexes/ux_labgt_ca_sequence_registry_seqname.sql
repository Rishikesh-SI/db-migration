-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ux_labgt_ca_sequence_registry_seqname
-- Type: INDEX

-- Name: ux_labgt_ca_sequence_registry_seqname; Type: INDEX; Schema: labgt; Owner: -
--

CREATE UNIQUE INDEX ux_labgt_ca_sequence_registry_seqname ON labgt.labgt_ca_sequence_registry USING btree (sequence_name);


--

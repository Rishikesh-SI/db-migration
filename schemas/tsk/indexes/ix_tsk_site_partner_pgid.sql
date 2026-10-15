-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_site_partner_pgid
-- Type: INDEX

-- Name: ix_tsk_site_partner_pgid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_site_partner_pgid ON tsk.tsk_page_partner USING btree (page_id);


--

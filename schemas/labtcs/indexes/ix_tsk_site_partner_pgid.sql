-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_site_partner_pgid
-- Type: INDEX

-- Name: ix_tsk_site_partner_pgid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_site_partner_pgid ON labtcs.labtcs_page_partner USING btree (page_id);


--

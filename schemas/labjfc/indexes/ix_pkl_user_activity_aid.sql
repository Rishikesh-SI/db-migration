-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_user_activity_aid
-- Type: INDEX

-- Name: ix_pkl_user_activity_aid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_user_activity_aid ON labjfc.labjfc_user_activity USING btree (user_id);


--
